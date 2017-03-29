{% from "avahi/map.jinja" import avahi with context %}

{% set services = salt['pillar.get']('avahi:services', {}) %}

{%- for service, params in services.items() %}
avahi_service_{{service}}:
  file.managed:
    - name: {{avahi.services_dir}}/{{service|lower}}.conf
    - source: salt://avahi/templates/service.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
      name: {{ params.name|default(service|lower) }}
      port: {{ params.port }}
      model: {{ params.model|default('RackMac') }}
    - require:
      - pkg: avahi_packages
    - watch_in:
      - module: avahi_service_reload
{%- endfor %}
