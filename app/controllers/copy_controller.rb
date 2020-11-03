require_relative '../services/read_copy_data_service.rb'
require_relative '../services/fetch_new_record_service'

class CopyController < ApplicationController
  before_action :check_file_exist, except: [:reset]

  def index
    if params[:since]
      render json: ReadCopyDataService.new(params).show_since_param
    else
      render json: ReadCopyDataService.new.get_complete_data
    end
  end

  def show
    render json: {value: ReadCopyDataService.new(params).get_key_data}
  end

  def reset
    if FetchNewRecordService.new.perform
      render json: {message: "Successfully updated"}
    else
      render json: {error: 'Unable to update'}
    end
  end

  private

  def check_file_exist
    unless File.exists?("public/copy.json")
      render json: {error: 'No file exist'}
    end
  end
end
