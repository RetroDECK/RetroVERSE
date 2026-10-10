#!/bin/bash

_prepare_component::rtdink() {
  local action="$1"
  shift

  local component_config="$(get_own_component_path)/rd_config"

  case "$action" in

    reset)
      log i "----------------------"
      log i "Resetting RTDink"
      log i "----------------------"

        export SDL_SOUNDFONTS="${SDL_SOUNDFONTS:-/app/retrodeck/components/rtdink/dink/midi/TimGM6mb.sf2}"

        create_dir "$XDG_DATA_HOME/rtdink"
        create_dir "$saves_path/dink"
        create_dir "$logs_path/dink"
        dir_prep "$roms_path/dink" "$XDG_DATA_HOME/rtdink/dmods"

        # Based on the official wrapper script for Dink Smallwood HD Flatpak 'dink-smallwood-hd.sh'

        ln -s "/app/retrodeck/components/rtdink/audio" "$XDG_DATA_HOME/rtdink/audio"
        ln -s "/app/retrodeck/components/rtdink/dink" "$XDG_DATA_HOME/rtdink/dink"
        ln -s "/app/retrodeck/components/rtdink/interface" "$XDG_DATA_HOME/rtdink/interface"

        for item in "/app/retrodeck/components/rtdink/dink/"*; do
            name="${item##*/}"
            [ -f "$XDG_DATA_HOME/rtdink/dink/$name" ] || ln -sfn "$item" "$XDG_DATA_HOME/rtdink/dink/$name"
        done       

        ln -sf "/app/retrodeck/components/rtdink/RTDinkApp" "$XDG_DATA_HOME/rtdink/RTDinkApp"
        ln -sf "/app/retrodeck/components/rtdink/fluidsynth" "$XDG_DATA_HOME/rtdink/fluidsynth"
        ln -sf "$XDG_DATA_HOME/rtdink/save.dat" "$saves_path/dink/save.dat"
        ln -sf "$XDG_DATA_HOME/rtdink/log.txt" "$logs_path/dink/log.txt"

    ;;

    postmove)
      log i "------------------------"
      log i "Post-moving RTDink"
      log i "------------------------"

        dir_prep "$roms_path/dink" "$XDG_DATA_HOME/rtdink/dmods"

    ;;

  esac
}


