# coding: utf-8
require 'thread'
require 'keeper/version'

# If you are looking for the documentation you’ll most likely want {Keeper::Keeper}.
#
module Keeper
  # A thread-safe blocking event pattern for your pleasure.
  #
  # @example
  #   events = Keeper::Keeper.new
  #
  #   [:pang, :boom, :pow].each_with_index do |event, i|
  #     this_many = i + 1
  #     this_many.times do |i|
  #       Thread.new do
  #         events.wait_for(event)
  #         puts "#{event}:#{i}!"
  #         events.fire(event == :pang ? :boom : :pow)
  #       end
  #     end
  #     puts "#{this_many} threads waiting for #{event}"
  #   end
  #
  #   print "Pause for effect"
  #   3.times { sleep 1 and print "." }
  #   puts
  #
  #   events.fire(:pang)
  #   Thread.list.reject { |th| th == Thread.current }.map(&:join)
  #
  class Keeper
    # Create a new {Keeper::Keeper} instance.
    def initialize
      @waiting = {}
      @mootex  = Mutex.new
    end

    # Fires the given event, waking up the waiting threads.
    #
    # @param [Symbol] event
    # @return [Keeper]
    def fire(event)
      @mootex.synchronize do
        condition = @waiting.delete(event)
        condition.broadcast unless condition.nil?
      end
      self
    end

    # Waits for the given event to fire.
    #
    # @param [Symbol] event
    # @return [Keeper]
    def wait_for(event)
      @mootex.synchronize do
        (@waiting[event] ||= ConditionVariable.new).wait(@mootex)
      end
      self
    end

    # A list of all events currently being waited for.
    #
    # @return [Array<Symbol>]
    def waiting
      @mootex.synchronize { @waiting.keys }
    end
  end
end