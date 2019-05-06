project('gu-provider-ui-linux',['c','vala'])

add_global_arguments('-DGETTEXT_PACKAGE="gu-provider-ui-linux"',language: 'c')

appindicator_0_1_dep = dependency('appindicator3-0.1')
atk_dep = dependency('atk')
cairo_dep = dependency('cairo')
gdk_3_0_dep = dependency('gdk-3.0')
gdk_pixbuf_2_0_dep = dependency('gdk-pixbuf-2.0')
gio_2_0_dep = dependency('gio-2.0')
gio_unix_2_0_dep = dependency('gio-unix-2.0')
glib_2_0_dep = dependency('glib-2.0')
gobject_2_0_dep = dependency('gobject-2.0')
gtk_3_0_dep = dependency('gtk+-3.0')
gee_dep = dependency('gee-0.8')
pango_dep = dependency('pango')
x11_dep = dependency('x11')
soup_dep = dependency('libsoup-2.4')
json_dep = dependency('json-glib-1.0')

#meson.add_install_script(join_paths(meson.current_source_dir(),'meson_scripts','install_data.sh'),join_paths(get_option('prefix'),get_option('datadir'),'gu-provider-ui-linux'),join_paths(meson.current_source_dir(),'data/local','','*'))
#meson.add_install_script(join_paths(meson.current_source_dir(),'meson_scripts','install_data.sh'),join_paths(get_option('prefix'),get_option('datadir'),'doc','gu-provider-ui-linux'),join_paths(meson.current_source_dir(),'doc','','*'))

install_data('data/icons/golem.svg',install_dir: join_paths(get_option('prefix'),get_option('datadir'),'icons','hicolor/scalable/apps'))
install_data('data/icons/golemu.png',install_dir: join_paths(get_option('prefix'),get_option('datadir'),'icons','hicolor/64x64/apps'))
install_data('data/icons/golemu-red.png',install_dir: join_paths(get_option('prefix'),get_option('datadir'),'icons','hicolor/64x64/apps'))
install_data('data/icons/golemu-green.png',install_dir: join_paths(get_option('prefix'),get_option('datadir'),'icons','hicolor/64x64/apps'))
#install_data('data/pixmaps/x.png',install_dir: join_paths(get_option('prefix'),get_option('datadir'),'gu-provider-ui-linux'))

install_data('data/gu-provider-ui-linux.desktop',install_dir: join_paths(get_option('sysconfdir'),'xdg','autostart'))
install_data('data/gu-provider-ui-linux.desktop',install_dir: join_paths(get_option('prefix'),get_option('datadir'),'applications'))

gnome = import('gnome')
resources = gnome.compile_resources('resources', 'data/resources.xml', source_dir: 'data', c_name: 'resources')

subdir('src')
