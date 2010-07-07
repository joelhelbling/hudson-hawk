class HudsonHawk
  attr_reader :server, :project

  def initialize(server, project)
    @server = server
    @project = project
  end

  def jobs_url
    json_url("#{@server}/#{@project}/jobs")
  end

  def job_url(job_number)
    json_url("#{@server}/#{@project}/#{job_number}")
  end

  def json_url(url)
    "#{ url.gsub(/\/+$/, '') }/api/json"
  end
end

describe HudsonHawk do
  before do
    @server = 'http://my.hudson.server:9080'
    @project = 'myProject'
    @hh = HudsonHawk.new(@server, @project)
  end

  it "should have a server" do
    @hh.server.should == @server
  end

  it "should have a project" do
    @hh.project.should == @project
  end

  it "should convert a Hudson URL to a Hudson API URL" do
    url = 'http://some.hudson.server/hudson/myProject/jobs'
    @hh.json_url(url).should == "#{url}/api/json"
    url2 = 'foo/'
    @hh.json_url(url2).should == "foo/api/json"
    url3 = 'foo//'
    @hh.json_url(url3).should == "foo/api/json"
  end

  it "should return a jobs URL" do
    @hh.jobs_url.should == "#{@server}/#{@project}/jobs/api/json"
  end

  it "should return a job URL" do
    @hh.job_url("1001").should == "#{@server}/#{@project}/1001/api/json"
  end
end
