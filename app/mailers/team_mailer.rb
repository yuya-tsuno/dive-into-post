class TeamMailer < ApplicationMailer
  def team_mail(pre_owner, new_owner, team)
    @pre_owner = pre_owner
    @new_owner = new_owner
    @team = team
    mail to: new_owner.email, subject: "Dive into post: チームのオーナー権限移動に関して"
  end
end