require_relative 'features/support/api_helper'
require          'json'
require          'optparse'
require          'ostruct'

class Optparse

  def self.parse(args)
    options = OpenStruct.new
    options.url = ''
    options.json = 'empty'
    options.job_name = 'empty'
    options.build_number = 0
    options.report_link = ''

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage:ruby reporter.rb [options]'
      opts.separator ''
      opts.separator 'Specific options:'

      opts.on('-u', '--url [URL]', 'Discord Webkit URL') do |url|
        options.url = url
      end

      opts.on('-j', '--json [JSON]', 'JSON report') do |json|
        options.json = json
      end

      opts.on('--job_name [JOB_NAME]', 'Jenkins job name') do |job_name|
        options.job_name = job_name
      end

      opts.on('--build_number [BUILD_NUMBER]', 'Jenkins build number') do |build_number|
        options.build_number = build_number
      end

      opts.on('--report_link [REPORT_LINK]', 'Jenkins report link') do |report_link|
        options.report_link = report_link
      end

      opts.on('--build_url [BUILD_URL]', 'Jenkins job build url') do |build_url|
        options.build_url = build_url
      end

      opts.separator ''
      opts.separator 'Options:'
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end
    opt_parser.parse!(args)
    options
  end
end

options = Optparse.parse(ARGV)

json_file = JSON.parse(File.new(options.json).read)
passed = json_file.select{|scenario| scenario["elements"].first["steps"].last["result"]["status"] == "passed"}.count
failed = json_file.select{|scenario| ["failed", "skipped"].include? scenario["elements"].first["steps"].last["result"]["status"]}.count
ratio = (passed * 100.0 / (passed + failed)).round(2)
ratio = ratio.to_i if ratio.to_i == ratio
color = 65280
color = 16711680 if failed.positive?

THUMBNAIL = { url: 'http://i0.kym-cdn.com/photos/images/original/000/016/217/CDOYGODMQGJQWKNBO4FAGFFUCUY3LCHS.jpeg' }
REPORT_LINK = "[Report Link](#{options.report_link}/#{options.build_number}/cucumber-html-reports/overview-features.html)"

fields = []
fields.push(name: 'Build Number', value: options.build_number)
fields.push(name: "Status", value: "Ratio: #{ratio}%\nPassed: #{passed}\nFailed: #{failed}")

embed = []
embed.push(title: options.job_name, description: REPORT_LINK, color: color, thumbnail: THUMBNAIL, fields: fields)
payload = {
  embeds: embed
}.to_json
response = API.post(options.url, payload: payload)