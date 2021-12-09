# macOS

Download cmake application, place in Applications directory, run, and select Menu -> Tools -> How to Install for Command Line Use. Run the command to symlink into /usr/local/bin.

Download ninja binary, move to /usr/local/bin, chown root:wheel /usr/local/bin/ninja.

Run `ninja` once; macOS security will kill it. Then visit "Security & Privacy" system preference pane, click "Allow", and run it again.

`cd llvm-project-13.x.x`
`cmake -S llvm -B build -G Ninja`
