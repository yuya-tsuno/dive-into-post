class AgendasController < ApplicationController
  before_action :set_agenda, only: %i[destroy]

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: I18n.t('views.messages.created_agenda')
    else
      redirect_to team_url(@agenda.team_id), notice: I18n.t('views.messages.failed_to_post')
    end
  end

  def destroy
    team = Team.find(@agenda.team_id)
    if current_user.id == @agenda.user_id || current_user.id == team.owner_id
      @agenda.destroy

      @agenda.team.assigns.each do |assign|
        AgendaMailer.agenda_mail(assign, current_user, @agenda).deliver
      end

      redirect_to dashboard_url, notice: I18n.t('views.messages.destroyed_agenda')
    else
      redirect_to team_url(@agenda.team_id), notice: I18n.t('views.messages.not_have_delete_rights')
    end
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end
end
