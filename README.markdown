Keeper!?
========
Ever wished you could spawn several threads, each of them waiting for a certain event to happen, without having to do the manual book-keeping of condition variables and mutexes? Now you can!

Keeper is a library that allows multiple threads to wait for incoming events. Have a look at this example code from the docs:

    events = Keeper::Keeper.new

    [:pang, :boom, :pow].each_with_index do |event, i|
      this_many = i + 1
      this_many.times do |i|
        Thread.new do
          events.wait_for(event)
          puts "#{event}:#{i}!"
          events.fire(event == :pang ? :boom : :pow)
        end
      end
      puts "#{this_many} threads waiting for #{event}"
    end

    print "Pause for effect"
    3.times { sleep 1 and print "." }
    puts

    events.fire(:pang)
    Thread.list.reject { |th| th == Thread.current }.map(&:join)
    
And here’s your output:

    1 threads waiting for pang
    2 threads waiting for boom
    3 threads waiting for pow
    Pause for effect...
    pang:0!
    boom:0!
    boom:1!
    pow:0!
    pow:2!
    pow:1!

Ain’t that awesome?! I think it is.

License
-------
X11. It means you can use Keeper for whatever you want as long as you ship the license text with it, it’s in LICENSE.txt.