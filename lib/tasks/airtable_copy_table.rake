require_relative '../../app/services/fetch_new_record_service'
result = FetchNewRecordService.new.perform
puts result