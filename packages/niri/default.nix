{pkgs, ...}:
pkgs.symlinkJoin {
  name = "niri";
  paths = with pkgs; [niri];
  nativeBuildInputs = with pkgs; [makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/niri \
      --add-flags '--config "${./config.kdl}"'

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
