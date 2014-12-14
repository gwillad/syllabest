class StudentMailer < ActionMailer::Base
  default from: "syllabestapp@gmail.com"
  
  def new_student(student, syllabus)
    @student = student
    @syllabus = syllabus
    mail(to: @student.email, subject: "You've been added to a Course")
  end

  def updated_syllabus(student, syllabus)
  	@student = 	student
  	@syllabus = syllabus
    mail(to: @student.email, subject: "There's been an update!")
  end
end
