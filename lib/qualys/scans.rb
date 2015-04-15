module Qualys
  class Scans < Api

    def self.all
      response = api_get("scan/", { :query => { :action => 'list' }} )
      scanlist = response.parsed_response['SCAN_LIST_OUTPUT']['RESPONSE']['SCAN_LIST']['SCAN']
      scanlist.map!{|scan| Scan.new(scan)}
    end

    def self.each
      self.all
    end

  end

  class Scan

    attr_accessor :ref, :title, :type, :date, :duration, :status, :target, :user

    def initialize(scan)
      @ref = scan['REF']
      @title = scan['TITLE']
      @type = scan['TYPE']
      @date = scan['LAUNCH_DATETIME']
      @duration = scan['DURATION']
      @status = scan['STATUS']['STATE']
      @target = scan['TARGET']
      @user = scan['USER_LOGIN']
    end

  end

  def finished?
    if @status.eql? 'Finished'
      return true
    end

    false
  end

end
