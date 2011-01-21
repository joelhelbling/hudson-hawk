module HudsonHawk
  class Server
    attr_reader :url, :project

    def initialize(url, project)
      @url = url
      @project = project
    end

    def jobs_url
      json_url("#{@url}/#{@project}/jobs")
    end

    def job_url(job_number)
      json_url("#{@url}/#{@project}/#{job_number}")
    end

    def json_url(url)
      "#{ url.gsub(/\/+$/, '') }/api/json"
    end
  end
end

describe HudsonHawk do
  before do
    @url = 'http://my.hudson.server:9080'
    @project = 'myProject'
    @server = HudsonHawk::Server.new(@url, @project)
  end

  it "should have a url" do
    @server.url.should == @url
  end

  it "should have a project" do
    @server.project.should == @project
  end

  it "should convert a Hudson URL to a Hudson API URL" do
    url = 'http://some.hudson.server/hudson/myProject/jobs'
    @server.json_url(url).should == "#{url}/api/json"
    url2 = 'foo/'
    @server.json_url(url2).should == "foo/api/json"
    url3 = 'foo//'
    @server.json_url(url3).should == "foo/api/json"
  end

  it "should return a jobs URL" do
    @server.jobs_url.should == "#{@url}/#{@project}/jobs/api/json"
  end

  it "should return a job URL" do
    @server.job_url("1001").should == "#{@url}/#{@project}/1001/api/json"
  end
end
