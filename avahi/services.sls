{% from "avahi/map.jinja" import avahi with context %}

{% set services = salt['pillar.get']('avahi:services', {}) %}

include:
  - avahi.install
  - avahi.service

{%- for service, params in services.items() %}
avahi_services_{{service}}:
  file.managed:
    - name: {{avahi.services_dir}}/{{service|lower}}.conf
    - source: salt://avahi/templates/service.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      service_name: "{{ params.name|default(service|lower) }}"
      service_type: {{ params.type|default(service|lower) }}
      service_port: {{ params.port }}
      service_model: {{ params.model|default('RackMac') }}
    - require:
      - pkg: avahi_packages
    - watch_in:
      - module: avahi_service_reload
{%- endfor %}
