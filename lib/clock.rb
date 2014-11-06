require './config/boot'
require './config/environment'
require 'clockwork'

include Clockwork



(0..23).each do |h|
  hstr = sprintf '%02d', h
  [0, 15, 30, 45].each do |m|
    mstr = sprintf '%02d', m
    time = "#{hstr}:#{mstr}"
    every(1.day, "Queing Sending Mail #{time}",  :at => time) { SendMailWorker.perform_async(time) }
  end
end
