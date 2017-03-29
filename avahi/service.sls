{% from "avahi/map.jinja" import avahi with context %}

include:
  - avahi.install

avahi_service:
  service.running:
    - name: {{ avahi.service }}
    - enable: True
    - require:
      - sls: avahi.install

# The following states are inert by default and can be used by other states to
# trigger a restart or reload as needed.
avahi_service_reload:
  module.wait:
    - name: service.reload
    - m_name: {{ avahi.service }}

avahi_service_restart:
  module.wait:
    - name: service.restart
    - m_name: {{ avahi.service }}
