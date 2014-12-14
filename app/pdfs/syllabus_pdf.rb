class SyllabusPdf < Prawn::Document
  def initialize(syllabus, components, user)
    super()
    @syllabus = syllabus
    @components = components
    @user = user
    #    font "ZapfDingbats"
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
    header_opts = @syllabus.header_options
    puts header_opts
    if header_opts[0] == "1"
      text @syllabus.title, size: 24, align: :center
    end
    if header_opts[1] == "1"
      text @syllabus.department + " " + @syllabus.course_num + " " +  @syllabus.course_type, size: 16, align: :center
    end
    if header_opts[2] == "1"
      text @user.school, size: 14, align: :center
    end
    if header_opts[3] == "1"
      text @syllabus.term, size: 14, align: :center
    end
    if header_opts[4] == "1"
      text @syllabus.location, size: 14, align: :center
    end
    font_size 11
    if header_opts[5] == "1"
      table [["Instructor:", @user.first_name + " " + @user.last_name]], cell_style: {borders: [], padding: 0}, width: 300
    end
    if header_opts[6] == "1"
      table [[ "Office:", @user.office]], cell_style: {borders: [], padding: 0}, width: 300
    end
    if header_opts[7] == "1"
      table [[ "Office Hours:", @syllabus.office_hrs.join(" ") ]], cell_style: {borders: [], padding: 0}, width: 300
      #TODO!
    end
    if header_opts[8] == "1"
      table [[ "Email:", @user.email]], cell_style: {borders: [], padding: 0}, width: 300
    end
    if header_opts[9] == "1"
      table [[ "Phone:", @user.phone]], cell_style: {borders: [], padding: 0}, width: 300
    end
    text "\n"
  end

  def sTable(t)
    title = t[0]
    text t.title, size: 14
    table t.contents, position: :center, header: true, width: 550, cell_style: {borders: if t.border_class == "border_hidden" then [] else [:top, :right, :bottom, :left] end}
    text "\n\n"
  end

  def plain(p)
    text p.title, size: 14
    text p.contents, size: 11
    text "\n\n"
  end

end
    
