class Usermailer < ApplicationMailer

  def servicecreated(service)
    @service = service
    mail(to: service.project.user.email, subject: "Service Item created")
  end

  def projectcreated(project)
    @project = project
    mail(to: project.user.email, subject: " Project created")
  end

end
