
module Fog
  module Parsers
    module AWS
      module AutoScaling

        class DescribeScalingActivities < Fog::Parsers::Base

          def reset
            @response = { 'Activities' => [] , 'ResponseMetadata' => {} }
            fresh_activity
          end

          def fresh_activity
            @launch_activity = {}
          end
          
          def end_element(name)
            
            case name
            when 'ActivityId', 'AutoScalingGroupName', 'Cause', 'Description', 'StatusCode', 'StatusMessage'
              @launch_activity[name]=value
            when 'StartTime', 'EndTime'
              @launch_activity[name] = Time.parse(value)
            when 'Progress'
              @launch_activity[name] = value.to_i
            when 'member'
              @response['Activities'] << @launch_activity
              fresh_activity
            when 'NextToken', 'RequestId'
              @response['ResponseMetadata'][name] = value
            end
          end

        end
      end
    end
  end
end
