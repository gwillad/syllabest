class SyllabusPdf < Prawn::Document
  def initialize(syllabus, components, user)
    super()
    @syllabus = syllabus
    @components = components
    @user = user
    header
    @components.each do |c|
      if c.component_type == "plaintext"
        p = c.plaintext
        plain(p)
      elsif c.component_type == "table"
        t = c.table
        sTable(t)
      end
    end
    
  end

  def header
#    font_size 20
    header_opts = @syllabus.header_options
    if header_opts[0] == "1"
      text @syllabus.title, size: 28, align: :center
    end
    if header_opts[1] == "1"
      text @syllabus.department + " " + @syllabus.course_num + " " +  @syllabus.course_type, size: 14, align: :center
    end
    if header_opts[2] == "1"
      text @syllabus.school, size: 12, align: :center
    if header_opts[3] == "1"
      text @syllabus.term, size: 12, align: :center
    end
    if header_opts[4] == "1"
      text "Instructor: " + @user.name, size: 12
    end
    #if header_opts[5] == "1"
    #  text @syllabus.location, size: 12, align: :center
    #end
    #if header_opts[6] == "1"
    #  text @syllabus.location, size: 12, align: :center
    #end
    #if header_opts[7] == "1"
    #  text @syllabus.location, size: 12, align: :center
    #end
    #if header_opts[8] == "1"
    #  text @syllabus.location, size: 12, align: :center
    #end
    #if header_opts[9] == "1"
    #  text @syllabus.location, size: 12, align: :center
    #end
    text "\n"
 #   font_size 10
  end

  def sTable(t)
    title = t[0]
    text t.title, size: 15
    puts t.contents
    table t.contents, position: :center, header: true, width: 550
    #t = t.slice(1..t.length)
    text "\n\n"
  end

  def plain(p)
    text p.title, size: 15
    text "\n"
    text p.contents
    text "\n\n"
  end

end
    
