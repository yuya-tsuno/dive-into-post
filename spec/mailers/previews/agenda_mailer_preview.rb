# Preview all emails at http://localhost:3000/rails/mailers/agenda
class AgendaPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/agenda/mailer
  def mailer
    AgendaMailer.mailer
  end

end
