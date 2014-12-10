require 'date'
class ComponentsController < ApplicationController

  respond_to :json
  before_action :find_syllabus, only: [:index, :show, :update, :create, :destroy]

  def index
    @response = @syllabus.components.all
    @jsonResponse = []
    @response.each do |h|
      if h.component_type == "plaintext"
        @plaintext = h.plaintext.as_json
        record = h.as_json
        record[:plaintext_attributes] = @plaintext
        @jsonResponse.push(record)
      elsif h.component_type == "table"
        @table = h.table.as_json
        p @table
        record = h.as_json
        record[:table_attributes] = @table
        @jsonResponse.push(record)
      end
    end
    respond_with @jsonResponse
  end

  def show
    @response = @syllabus.components.find(params[:id])
    @plaintext = @response.plaintext
    @response = @response.as_json
    @response[:plaintext_attributes] = @plaintext.as_json
    respond_with @response
  end
  
  def update
    params.permit!
    p params
    @record = @syllabus.components.update(params[:id].to_i, params[:component])
    respond_with @user, @syllabus, @record
  end
  
  def create
    params.permit!
    if params[:component][:component_type]=="calendar" #creates calendar out of table
      params[:component][:component_type] = "table"
      dates = generate_dates(Date.parse(params[:component][:start_date]), Date.parse(params[:component][:end_date]), params[:component][:meeting_days], vacation_days)
      new_contents = []
      new_contents.push(Array.new(params[:component][:table_attributes][:columns], "Column Title"))
      new_contents[0][0] = "Dates"
      dates.each do |day|
        new_row = Array.new(params[:component][:table_attributes][:columns], "Cell Data")
        new_row[0] = [day_of_week(day) + ",", month(day.month), day.day.to_s + ",", day.year].join(" ")
        new_contents.push(new_row)
      end
      params[:component][:table_attributes][:rows] = dates.length
      params[:component][:table_attributes][:contents] = new_contents
    end
    @record = @syllabus.components.create(params[:component])
    respond_with @user, @syllabus, @record
  end
  
  def destroy
    respond_with @syllabus.components.destroy(params[:id])
  end
  
  private
  def component_params
    params.require(:component).permit(:id, :order, :component_type, :order, :syllabus_id, plaintext_attributes: [:title, :contents, :component_id, :id], table_attributes: [:title, :rows, :columns, :border_class])
  end

  def find_syllabus
    @syllabus = Syllabus.find(params[:syllabus_id])
    @user = User.find(@syllabus[:user_id])
  end

  def generate_dates(start_date, end_date, meeting_days, vacation_days)
    # returns a list of dates the class meets on
    res = Array.new
    index = start_date.wday
    (start_date .. end_date).each do |i|
      if not (vacation_days.include?(i))
        if meeting_days[index]
          res.push(i)
        end
      end
      index = (index + 1) % 7
    end
    return res
  end
  
  def vacation_days
    v_days = [Date.new(2014, 10, 16),
              Date.new(2014, 10, 17),
              Date.new(2014, 10, 18),
              Date.new(2014, 10, 19),
              Date.new(2014, 10, 16)]
    (Date.new(2014, 11, 22) .. Date.new(2014, 11, 30)).each do |d|
      v_days.push(d)
    end
    return v_days
  end

  def day_of_week(day)
    if day.monday?
      return "Monday"
    end
    if day.tuesday?
      return "Tuesday"
    end
    if day.wednesday?
      return "Wednesday"
    end
    if day.thursday?
      return "Thursday"
    end
    if day.friday?
      return "Friday"
    end
    if day.saturday?
      return "Saturday"
    end
    if day.sunday?
      return "Sunday"
    end
  end
  
  def month(mon)
    if mon == 1
      return "Jan"
    end
    if mon == 2
      return "Feb"
    end
    if mon == 3
      return "Mar"
    end
    if mon == 4
      return "Apr"
    end
    if mon == 5
      return "May"
    end
    if mon == 6
      return "Jun"
    end
    if mon == 7
      return "Jul"
    end
    if mon == 8
      return "Aug"
    end
    if mon == 9
      return "Sep"
    end
    if mon == 10
      return "Oct"
    end
    if mon == 11
      return "Nov"
    end
    if mon == 12
      return "Dec"
    end

    
  end
end
