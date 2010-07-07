class HudsonHawk
  
  def json_url(url)
    "#{ url.gsub(/\/$/, "") }/api/json"
  end
end

describe HudsonHawk do
  before do
    @hh = HudsonHawk.new
  end

  it "should convert a Hudson URL to a Hudson API URL" do
    url = 'http://some.hudson.server/hudson/myProject/jobs'
    @hh.json_url(url).should == "#{url}/api/json"
    url2 = 'foo/'
    @hh.json_url(url2).should == "foo/api/json"
  end
end
