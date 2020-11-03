require 'json'
require_relative 'fetch_new_record_service'
class ReadCopyDataService
  def initialize params = nil
    file = File.read('public/copy.json')
    @data = JSON.parse(file)
    @params = params
  end

  def get_complete_data
    @data
  end

  def show_since_param
    if FetchNewRecordService.new.write_without_created_and_updated_at
      file = File.read('public/copy.json')
      JSON.parse(file)
    end
  end

  def get_key_data
    case @params[:key]
    when 'greeting'
      return get_greeting_data
    when 'intro'
      return intro
    else
      @data[@params[:key]]
    end
  end

  private

  def intro
    if @params[:created_at]
      key_name = 'intro.created_at'
      intro_created_at = @data[key_name]
      intro_created_at.sub!('{created_at, datetime}', covert_date_to_require_format(@params[:created_at]))
    elsif @params[:updated_at]
      key_name = 'intro.updated_at'
      intro_updated_at = @data[key_name]
      intro_updated_at.sub!('{updated_at, datetime}', covert_date_to_require_format(@params[:updated_at]))
    else
      'no data available'
    end
  end

  def covert_date_to_require_format date
    DateTime.strptime(date, '%s').strftime("%a %B %d %I:%M:%S%p")
  end

  def get_greeting_data
    if @data[@params[:key]]
      greeting = @data[@params[:key]]
      greeting.sub!('{name}', @params[:name])
      greeting.sub!('{app}', @params[:app])
      greeting
    else
      'no data available'
    end
  end
end