{
  # Enable sound with pipewire.
  services.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    extraConfig = {
      pipewire."60-echo-cancel" = {
        context.modules = [

          # Echo cancellation
          {
            name = "libpipewire-module-echo-cancel";
            args = {

              # Monitor mode: Instead of creating a virtual sink into which all
              # applications must play, in PipeWire the echo cancellation module can read
              # the audio that should be cancelled directly from the current fallback
              # audio output
              monitor.mode = true;

              # The audio source / microphone wherein the echo should be cancelled is not
              # specified explicitely; the module follows the fallback audio source setting
              source.props = {

                # Name and description of the virtual source where you get the audio
                # without echoed speaker output
                node.name = "source_ec";
                node.description = "Echo-cancelled source";
              };
              aec.args = {

                # Settings for the WebRTC echo cancellation engine
                webrtc.gain_control = true;
                webrtc.extended_filter = false;

                # Other WebRTC echo cancellation settings which may or may not exist
                # Documentation for the WebRTC echo cancellation library is difficult
                # to find

                #webrtc.analog_gain_control = false
                #webrtc.digital_gain_control = true
                #webrtc.experimental_agc = true
                #webrtc.noise_suppression = true
              };
            };
          }
        ];

      };
    };
  };

  # From https://wiki.archlinux.org/title/PipeWire/Examples#Echo_cancellation
}
