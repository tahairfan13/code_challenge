require 'json'
class FetchNewRecordService

  def initialize
    @api_key = "keyTucTLpGVvO0fh2"
    @base_key = "app8mDu8BXHLDLZZr"
    @table_name = "copy"
  end

  def perform
    File.open("public/copy.json","w") do |f|
      f.write(create_hash.to_json)
    end
    File.exists?("public/copy.json")
  end

  def write_without_created_and_updated_at
    hash = create_hash
    hash.delete('intro.created_at')
    hash.delete('intro.updated_at')
    File.open("public/copy.json","w") do |f|
      f.write(hash.to_json)
    end
    File.exists?("public/copy.json")
  end

  private

  def create_hash
    result = Airrecord.table(@api_key, @base_key, @table_name)
    json_hash = Hash.new
    result.all.each do |record|
      hash = Hash["#{record['key']}" => record["Copy"]]
      json_hash = json_hash.merge(hash)
    end
    json_hash
  end
end