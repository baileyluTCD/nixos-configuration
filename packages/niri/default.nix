{ pkgs, flake, ... }:
  let
  config = pkgs.replaceVars ./config.kdl (with flake.lib.colorScheme.palette; {
    activeColorStart = base0A;
    activeColorEnd = base0B;
    inactiveColor = base02;
    DEFAULT_AUDIO_SINK = null;
    DEFAULT_AUDIO_SOURCE = null;
  });
in
pkgs.symlinkJoin {
  name = "niri";
  paths = with pkgs; [ niri ];
  nativeBuildInputs = with pkgs; [ makeWrapper ];
  postBuild = ''
    cp $out/bin/niri $out/bin/niri-unwrapped

    # Use integrated GPU as primary
    # 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA106M [GeForce RTX 3060 Mobile / Max-Q] [10de:2520] (rev a1)
    # 05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] [1002:1638] (rev c6)
    wrapProgram $out/bin/niri \
      --add-flags '--config "${config}"' \
      --set DRI_PRIME "pci-0000_05_00_0"

    rm $out/lib/systemd/user/niri.service

    cat << EOF > $out/lib/systemd/user/niri.service
    [Unit]
    Description=A scrollable-tiling Wayland compositor
    BindsTo=graphical-session.target
    Before=graphical-session.target
    Wants=graphical-session-pre.target
    After=graphical-session-pre.target

    Wants=xdg-desktop-autostart.target
    Before=xdg-desktop-autostart.target

    [Service]
    Slice=session.slice
    Type=notify
    ExecStart=$out/bin/niri --session
    EOF
  '';

  passthru = pkgs.niri.passthru;
}
