class AgendaMailer < ApplicationMailer
  def agenda_mail(assign, deleting_user, deleted_agenda)
    @team = assign.team
    @team_member = assign.user
    @deleting_user = deleting_user
    @deleted_agenda = deleted_agenda

    mail to: @team_member.email,
    subject: "アジェンダ削除に関して" 
  end
end
