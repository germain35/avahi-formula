{% from "avahi/map.jinja" import avahi with context %}

include:
  - avahi.install
  - avahi.service

avahi_config:
  file.managed:
    - name: {{ avahi.config }}
    - template: jinja
    - source: salt://avahi/templates/avahi-daemon.conf
    - require:
      - pkg: avahi_packages
    - watch_in:
      - service: {{ avahi.service }}
