DataMapper.setup(:default, 'mysql://root:04123612775@localhost/ChipTester')

class DUV_Descriptor
  include DataMapper::Resource
  
  property :id, Serial  # An auto-increment integer key
  property :chip_number, Integer,:required => true # The number of the chip
  property :team_number, Integer      # The number of the team
  property :configure_date, DateTime  # A DateTime, for any date you might like.
end

class DUV_Results
  include DataMapper::Resource
  property :id, Serial  # An auto-increment integer key
  property :id_test, String
  property :chip_number, Integer, :required => true #The number of the chip
  property :team_number, Integer 
  property :test_passed, Boolean, :required => true #If the test passed or not
end

class DUV_Fail
  include DataMapper::Resource
  property :id, Serial
  property :id_test, String
  property :fail_result, String, :required => true
  property :expected_result, String, :required => true
end
def Store_DUV_Result(json_parsed)
      @duv_result = DUV_Results.create(
	:id_test => json_parsed["DUV_Results"]["id_test"],
	:chip_number => json_parsed["DUV_Results"]["chip_number"],
	:team_number => json_parsed["DUV_Results"]["team_number"],
	:test_passed => json_parsed["DUV_Results"]["test_passed"]
      )
      @duv_result.save
end      
def Store_DUV_Fail(json_parsed)
    @duv_fail = DUV_Fail.create(
	:id_test => json_parsed["DUV_Fail"]["id_test"],
	:fail_result => json_parsed["DUV_Fail"]["fail_result"],
	:expected_result => json_parsed["DUV_Fail"]["expected_result"]
      )
    @duv_fail.save
end
DataMapper.finalize
DataMapper.auto_upgrade!