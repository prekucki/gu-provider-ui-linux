cfg_gu_provider_indicator = configuration_data()
cfg_gu_provider_indicator.set('DATADIR', join_paths(get_option('prefix'),get_option('datadir')))
cfg_gu_provider_indicator.set('PKGDATADIR', join_paths(get_option('prefix'),get_option('datadir'),'gu-provider-indicator'))
cfg_gu_provider_indicator.set('GETTEXT_PACKAGE', 'gu-provider-indicator')
cfg_gu_provider_indicator.set('RELEASE_NAME', 'gu-provider-indicator')
cfg_gu_provider_indicator.set('PREFIX', get_option('prefix'))
cfg_gu_provider_indicator.set('VERSION', '1.0.0')
cfg_gu_provider_indicator.set('TESTSRCDIR', meson.source_root())

cfgfile_1 = configure_file(input: 'Config.vala.base',output: 'Config.vala',configuration: cfg_gu_provider_indicator)

gu_provider_indicator_deps = [appindicator_0_1_dep]
gu_provider_indicator_deps += [atk_dep]
gu_provider_indicator_deps += [cairo_dep]
gu_provider_indicator_deps += [gdk_3_0_dep]
gu_provider_indicator_deps += [gdk_pixbuf_2_0_dep]
gu_provider_indicator_deps += [gio_2_0_dep]
gu_provider_indicator_deps += [glib_2_0_dep]
gu_provider_indicator_deps += [gobject_2_0_dep]
gu_provider_indicator_deps += [gtk_3_0_dep]
gu_provider_indicator_deps += [pango_dep]
gu_provider_indicator_deps += [x11_dep]
gu_provider_indicator_sources = [cfgfile_1]
gu_provider_indicator_sources += ['gu-provider-indicator.vala']
gu_provider_indicator_link_args = ['-rdynamic']

executable('gu-provider-indicator',gu_provider_indicator_sources,dependencies: gu_provider_indicator_deps,link_args: gu_provider_indicator_link_args,install: true)

