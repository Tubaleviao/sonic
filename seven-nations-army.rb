#use_synth :fm
#play 40, sustain: 0.2, amp: 2
# 0.47

define :base_bass do
  use_synth :fm
  play :e3, sustain: 0.3, amp: 2
  sleep 0.77
  play :e3, sustain: 0.1, amp: 2, release: 0.1
  sleep 0.23
  play :g3, sustain: 0.1, amp: 2, release: 0.1
  sleep 0.35
  play :e3, sustain: 0.1, amp: 2, release: 0.1
  sleep 0.35
  play :d3, sustain: 0.1, amp: 2, release: 0.1
  sleep 0.3
  play :c3, sustain: 0.2, amp: 2
  sleep 1
  play :b2, sustain: 0.2, amp: 2, release: 0.8
  sleep 1
end

define :base_drum do
  sample :drum_heavy_kick, amp: 2
  sleep 0.5
end

define :cool_drum do
  sample :drum_heavy_kick, amp: 2
  sleep 0.5
  sample :drum_heavy_kick, amp: 2
  sample :drum_snare_hard
  sleep 0.5
end

define :loud_drum do
  sample :drum_splash_hard
  sample :drum_heavy_kick, amp: 2
  sleep 0.5
  sample :drum_splash_hard
  sample :drum_snare_hard
  sleep 0.5
end

define :splash do
  sample :drum_splash_hard
  sleep 0.25
end

define :guitar do |n, div=3, rel=0.5, sl=0.25, sus=0|
  use_synth :fm
  with_fx :distortion, distort: 0.8 do
    play n, divisor:(div), release: rel, sustain: sus
  end
  sleep sl
end

define :drum_detail do
  in_thread do
    sample :drum_splash_hard
    sample :drum_heavy_kick, amp: 2
  end
  sleep 0.4
  in_thread do
    sample :drum_heavy_kick, amp: 2
  end
  sleep 0.1
  in_thread do
    sample :drum_splash_hard
  end
  sleep 0.25
  in_thread do
    sample :drum_snare_hard
  end
  sleep 0.2
  sleep 0.1
end


define :beginning do
  2.times do base_bass end
  6.times do
    in_thread do
      8.times do base_drum end
    end
    base_bass
  end
  4.times do
    in_thread do
      4.times do cool_drum end
    end
    base_bass
  end
end

define :transition do
  in_thread do
    8.times do
      guitar :g4
    end
    8.times do
      guitar :a4
    end
  end
  in_thread do
    8.times do
      base_drum
    end
  end
  in_thread do
    2.times do
      splash
      sleep 1.75
    end
  end
  
  sleep 4
end

define :riff do
  in_thread do
    with_fx :compressor, amp: 0.8 do
      guitar :e5, 4, 1, 0.77, 0
      guitar :e5, 4, 0.1, 0.23, 0.1
      guitar :g5, 4, 0.1, 0.35, 0.1
      guitar :e5, 4, 0.1, 0.35, 0.1
      guitar :d5, 4, 0.1, 0.3, 0.1
      guitar :c5, 4, 1, 1, 0.2
      guitar :b4, 4, 0.9, 1, 0.1
      
      guitar :e5, 4, 1, 0.77, 0.3
      guitar :e5, 4, 0.1, 0.23, 0.1
      guitar :g5, 4, 0.1, 0.35, 0.1
      guitar :e5, 4, 0.1, 0.35, 0.1
      guitar :d5, 4, 0.1, 0.3, 0.1
      guitar :c5, 4, 0.1, 0.3, 0.2
      guitar :d5, 4, 0.1, 0.35, 0.1
      guitar :c5, 4, 0.1, 0.35, 0.2
      guitar :b4, 4, 0.9, 1, 0.1
    end
  end
end

define :cool_guitar do |climax=false|
  if(climax)
    solo
  else
    riff
  end
  4.times do
    loud_drum
  end
  loud_drum
  drum_detail
  2.times do loud_drum end
  
  if(climax)
    solo
  else
    riff
  end
  4.times do
    loud_drum
  end
  loud_drum
  drum_detail
  2.times do loud_drum end
end

define :solo do
  in_thread do
    # |n, div=3, rel=0.5, sl=0.25, sus=0|
    with_fx :compressor, amp: 0.9 do
      guitar :e6, 4, 1, 0.77, 0
      guitar :e6, 4, 0.1, 0.23, 0.1
      guitar :g6, 4, 0.1, 0.35, 0.1
      guitar :e6, 4, 0.1, 0.35, 0.1
      guitar :d6, 4, 0.1, 0.3, 0.1
      guitar :g6, 4, 1, 1, 0.5
      guitar :f6, 4, 0.9, 1, 0.4
      
      guitar :e6, 4, 1, 0.77, 0.3
      guitar :e6, 4, 0.1, 0.23, 0.1
      guitar :g6, 4, 0.1, 0.35, 0.1
      guitar :a6, 4, 0.1, 0.35, 0.1
      guitar :g6, 4, 0.1, 0.3, 0.1
      guitar :f6, 4, 0.1, 0.3, 0.2
      guitar :g6, 4, 0.1, 0.35, 0.1
      guitar :f6, 4, 0.1, 0.35, 0.2
      guitar :e6, 4, 0.9, 1, 0.1
    end
  end
end

beginning
transition
cool_guitar

transition

in_thread do
  sample :drum_splash_hard
end
beginning
transition
cool_guitar

# solo
cool_guitar true

# going back transition with solo
transition

# beginning with static
in_thread do
  sample :drum_splash_hard
end
beginning

# scaling transition
transition

# cool guitar
cool_guitar

# reverbing notes at the end
