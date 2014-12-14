class StudentMailer < ActionMailer::Base
  default from: "syllabestapp@gmail.com"
  
  def new_student(student, syllabus)
    @student = student
    @syllabus = syllabus
    mail(to: @student.email, subject: "You've been added to a Course")
  end

  def updated_syllabus(student, syllabus)
    @student = student
    @syllabus = syllabus
    @user = User.find(@syllabus.user_id)
    components = @syllabus.components.all

    pdf = SyllabusPdf.new(@syllabus, components, @user)
    pdf_contents = pdf.render
#    title = @syllabus.title + ".pdf"
#    send_data pdf.render, filename: title, type: "application/pdf", disposition: "inline"
    
    attachments["syllabus.pdf"] = {
      mime_type: 'application/pdf',
      content: pdf_contents
    }#File.read("http://gemini.cs.hamilton.edu:3008/pdf/users/" + @syllabus.user_id.to_s + "/syllabuses/" + @syllabus.id.to_s + ".pdf")
    mail(to: @student.email, subject: "There's been an update!")
  end
end
