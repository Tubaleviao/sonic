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

define :cool_guitar do
  riff
  4.times do
    loud_drum
  end
  loud_drum
  drum_detail
  2.times do loud_drum end
  
  riff
  4.times do
    loud_drum
  end
  loud_drum
  drum_detail
  2.times do loud_drum end
end

define :solo1 do
  use_synth :fm
  with_fx :compressor, amp: 0.8 do
    in_thread do
      with_fx :distortion, distort: 0.8 do
        play :g6, divisor:(4), attack: 2, attack_level: 0.2, decay: 0.1, decay_level: 1, sustain: 1, release: 0.1, sustain_level: 1
        sleep 3
        play :f6, divisor:(4), attack: 0.1, sustain: 0.8, release: 0.1
        sleep 1
      end
      guitar :e6, 4, 1, 0.77, 0.3
      guitar :e6, 4, 0.1, 0.23, 0.1
      guitar :g6, 4, 0.1, 0.35, 0.1
      guitar :a6, 4, 0.1, 0.35, 0.1
      guitar :g6, 4, 0.1, 0.3, 0.1
      guitar :f6, 4, 0.1, 0.3, 0.2
      guitar :g6, 4, 0.1, 0.35, 0.1
      guitar :f6, 4, 0.1, 0.35, 0.2
      guitar :e6, 4, 0.9, 1, 0.1
      
      with_fx :distortion, distort: 0.8 do
        play :e6, divisor:(4), sustain: 0.57, release: 0.2
        sleep 0.77
        play :f6, divisor:(4), sustain: 0.15, release: 0.1
        sleep 0.25
        play :d6, divisor:(4), sustain: 0.13, release: 0.1
        sleep 0.23
        play :e6, divisor:(4), sustain: 0.12, release: 0
        sleep 0.12
        play :f6, divisor:(4), sustain: 0.15, release: 0.1
        sleep 0.25
        play :e6, divisor:(4), sustain: 0.25, release: 0.1
        sleep 0.38
        play :g6, divisor:(4), sustain: 0.8, release: 0.2
        sleep 1
        play :f6, divisor:(4), sustain: 0.6, release: 0.4
        sleep 1
      end
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

define :solo2 do
  in_thread do
    with_fx :compressor, amp: 0.9 do
      guitar :e7, 4, 1, 0.77, 0
      guitar :e7, 4, 0.1, 0.23, 0.1
      guitar :g7, 4, 0.1, 0.35, 0.1
      guitar :e7, 4, 0.1, 0.35, 0.1
      guitar :d7, 4, 0.1, 0.3, 0.1
      
      #    guitar :g7, 4, 1, 1, 0.5
      with_fx :compressor, amp: 0.9 do
        with_fx :distortion, distort: 0.8 do
          use_synth :fm
          play :g7, divisor:(4), attack_level: 1, decay: 0.5, decay_level: 0.1, sustain: 0.5, sustain_level: 0.1, release: 0.1
          play :g8, divisor:(4), attack_level: 0.1, decay: 0.5, decay_level: 1, sustain: 0.3, release: 0.3
          sleep 1
        end
      end
      
      guitar :f7, 4, 1, 1, 0.2
      
      guitar :e7, 4, 1, 0.77, 0.3
      guitar :e7, 4, 0.1, 0.23, 0.1
      guitar :g7, 4, 0.1, 0.35, 0.1
      guitar :a7, 4, 0.1, 0.35, 0.1
      guitar :g7, 4, 0.1, 0.3, 0.1
      guitar :f7, 4, 0.1, 0.3, 0.2
      guitar :g7, 4, 0.1, 0.35, 0.1
      guitar :f7, 4, 0.1, 0.35, 0.2
      guitar :e7, 4, 0.9, 1, 0.1
      
      # pt 2
      
      with_fx :compressor, amp: 0.9 do
        with_fx :distortion, distort: 0.8 do
          use_synth :fm
          play :e7, divisor:(4), sustain: 0.57, release: 0.2
          sleep 0.77
          play :f7, divisor:(4), sustain: 0.14, release: 0.1
          sleep 0.15
          play :f7, divisor:(4), sustain: 0.14, release: 0.1
          sleep 0.15
          play :g7, divisor:(4), sustain: 0.32, release: 0.1
          sleep 0.37
          play :f7, divisor:(4), sustain: 0.15, release: 0.1
          sleep 0.25
          play :e7, divisor:(4), sustain: 0.25, release: 0.9
          sleep 0.4
          #play :g7, divisor:(4), sustain: 0.8, release: 0.2
          with_fx :distortion, distort: 0.8 do
            play :g7, divisor:(4), attack_level: 1, decay: 0.4, decay_level: 0.1, sustain: 0.5, release: 0.1
            play :g6, divisor:(4), attack_level: 0.1, decay: 0.4, decay_level: 1, sustain: 0.5,  release: 0.1, amp: 0.2
            sleep 1
            play :f7, divisor:(4), sustain: 0.6, release: 0.4
            play :f6, divisor:(4), attack_level: 0.1, decay: 0.9, decay_level: 1, release: 0.1
            sleep 1
          end
        end
      end
      
      guitar :e7, 4, 1, 0.77, 0.3
      guitar :e7, 4, 0.1, 0.23, 0.1
      guitar :g7, 4, 0.1, 0.35, 0.1
      guitar :e7, 4, 0.1, 0.35, 0.1
      guitar :e7, 4, 0.1, 0.3, 0.1
      guitar :g7, 4, 0.1, 0.3, 0.2
      guitar :e7, 4, 0.1, 0.35, 0.1
      guitar :d7, 4, 0.1, 0.35, 0.2
      guitar :c7, 4, 0.5, 1, 0.5
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

# solo

solo1
cool_guitar

# solo 2 high
solo2
cool_guitar

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
