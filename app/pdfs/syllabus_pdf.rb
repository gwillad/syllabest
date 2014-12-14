require 'time'

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
    self
  end
  
  def header
    header_opts = @syllabus.header_options
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
      table [["Instructor: ", @user.first_name + " " + @user.last_name]], cell_style: {borders: [], padding: 0}, column_widths: {0 => 70}
    end
    if header_opts[6] == "1"
      table [[ "Office: ", @user.office]], cell_style: {borders: [], padding: 0}, column_widths: {0 => 70}
    end
    if header_opts[7] == "1"
      office_hours_list = [[""]]
      day_list = @days
      count = 0
      @syllabus.office_hrs.each do |range|
        new_range = ["", ""]
        if count == 0
          new_range[0] = "Office Hours:"
        end
        if range[0] != "" and range[1] != ""
          new_range[1] = days[count]
          new_range[1] += (Time.parse(range[0]).strftime("%I:%M%p"))
          new_range[1] += " - "
          new_range[1] += (Time.parse(range[1]).strftime("%I:%M%p"))
        end
        count += 1
        office_hours_list.push(new_range)
      end
      table office_hours_list, cell_style: {borders: [], padding: 0}, column_widths: {0 => 70}
    end
    if header_opts[8] == "1"
      table [[ "Email: ", @user.email]], cell_style: {borders: [], padding: 0}, column_widths: {0 => 70}
    end
    if header_opts[9] == "1"
      table [[ "Phone: ", @user.phone]], cell_style: {borders: [], padding: 0}, column_widths: {0 => 70}
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

  def days
    return ["Sun ", "Mon ", "Tues ", "Wed ", "Thur ", "Fri ", "Sat "]
  end

end
    
