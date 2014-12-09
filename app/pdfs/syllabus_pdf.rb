class SyllabusPdf < Prawn::Document
  def initialize(syllabus, components)
    super()
    @syllabus = syllabus
    @components = components
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
    font_size 20
    text @syllabus.title, size: 28, align: :center
    text @syllabus.department + " " + @syllabus.course_num + " " +  @syllabus.course_type, size: 14, align: :center
    text @syllabus.term, size: 14, align: :center
    text "\n"
    font_size 10
  end

  def sTable(t)
    title = t[0]
    text t.title
    puts t.contents
    table t.contents, position: :center, header: true, width: 550
    #t = t.slice(1..t.length)
    
  end

  def plain(p)
    text p.title, size: 20
    text "\n"
    text p.contents
    text "\n\n"
  end

end
    
