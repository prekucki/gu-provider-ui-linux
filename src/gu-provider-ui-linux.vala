using AppIndicator;
using Gtk;
using Soup;
using Json;
using Avahi;

Window window;
Gtk.Menu menu;
Gtk.ListStore hub_list_model;
Avahi.Client avahi_client;
List<Avahi.ServiceResolver> avahi_resolvers;

public void on_configure_menu_activate(Gtk.MenuItem menu) {
    window.show_all();
}

public void on_hub_selected_toggled(CellRendererToggle toggle, string path) {
    TreeIter iter;
    hub_list_model.get_iter(out iter, new TreePath.from_string(path));
    hub_list_model.set(iter, 0, !toggle.active);
}

/*
public void on_found (Interface @interface, Protocol protocol, string name, string type, string domain, string hostname, Address? address, uint16 port, StringList? txt) {
    print ("Found name %s, type %s, port %u address%s\n", name, type, port, address.to_string ());
}
public void on_new_service (Interface @interface, Protocol protocol, string name, string type, string domain, LookupResultFlags flags) {
    ServiceResolver service_resolver = new ServiceResolver (Interface.UNSPEC,
                                                            Protocol.UNSPEC,
                                                            name,
                                                            type,
                                                            domain,
                                                            Protocol.UNSPEC);
    service_resolver.found.connect (on_found);
    service_resolver.failure.connect ( (error) => {
        warning (error.message);
    });

    try {
        service_resolver.attach (client);
    } catch (Avahi.Error e) {
        warning (e.message);
    }

    resolvers.append (service_resolver);
}
*/

public void on_found_new_node(Interface @interface, Protocol protocol, string name, string type, string domain, string hostname, Avahi.Address? address, uint16 port, StringList? txt) {
    stdout.printf("YES %s %s %s %s %s %s\n", name, type, domain, hostname, address.to_string(), protocol.to_string());
}

public void on_new_avahi_service (Interface @interface, Protocol protocol, string name, string type, string domain, LookupResultFlags flags) {
    stdout.printf("%s %s %s\n", name, type, domain);
    ServiceResolver resolver = new ServiceResolver(Interface.UNSPEC, protocol, name, type, domain, protocol);
    resolver.found.connect(on_found_new_node);
    resolver.failure.connect((err) => { warning(err.message); });
    try {
        resolver.attach(avahi_client);
        avahi_resolvers.append(resolver);
    } catch (Avahi.Error err) { warning(err.message); }
}

int main(string[] args) {
    Gtk.init(ref args);

    var indicator = new Indicator("Golem Unlimited Provider UI", "golemu", IndicatorCategory.APPLICATION_STATUS);

    var builder = new Gtk.Builder();
    try {
        builder.add_from_resource("/network/golem/gu-provider-ui-linux/window.glade");
        window = builder.get_object("window") as Window;
        menu = builder.get_object("menu") as Gtk.Menu;
        hub_list_model = builder.get_object("hub_list_model") as Gtk.ListStore;
        builder.connect_signals(null);
    } catch (GLib.Error e) {
        stderr.printf("Error while loading GUI: %s\n", e.message);
        return 1;
    }

    //-------------------------------------------------------------------------------------------------
    var avahi_service_browser = new ServiceBrowser("_unlimited._tcp");
    avahi_service_browser.new_service.connect(on_new_avahi_service);
    avahi_resolvers = new List<ServiceResolver>();
    avahi_client = new Client();
    try {
        avahi_client.start();
        stdout.printf("HELLO\n");
        avahi_service_browser.attach(avahi_client);
    } catch (Avahi.Error err) { warning(err.message); }

    //-------------------------------------------------------------------------------------------------

    //indicator.set_status(IndicatorStatus.ATTENTION);
    //indicator.set_attention_icon("x");
    //indicator.set_label("Connected", "A");

    indicator.set_status(IndicatorStatus.ACTIVE);
    indicator.set_icon("golemu");
    indicator.set_menu(menu);

    /*var list = new Gtk.ListStore(2, typeof(bool), typeof(string));
    TreeIter iter; list.append(out iter); list.set(iter, 0, true, 1, "hello");
    list.foreach(() => { stdout.printf("Test 1\n"); return false; });
    hub_list.set_model(list);*/

    /*
    var session = new Soup.Session();
    var message = new Soup.Message("GET", "http://localhost:61621/connections/list/all");
    session.send_message(message);
    message.response_headers.foreach ((name, val) => { stdout.printf ("Name: %s -> Value: %s\n", name, val); });
    stdout.printf("Message length: %lld\n%s\n", message.response_body.length, message.response_body.data);
    */

    string cli_hub_info;
    try {
        Process.spawn_command_line_sync ("gu-provider --json lan list -I gu-hub", out cli_hub_info, null, null);
    } catch (GLib.Error err) { warning(err.message); }
    //stdout.printf(cli_hub_info);

    var json_parser = new Json.Parser();
    //json_parser.load_from_data((string)message.response_body.flatten().data, -1);
    try {
        json_parser.load_from_data(cli_hub_info, -1);
    } catch (GLib.Error err) { warning(err.message); }
    var answer = json_parser.get_root().get_array();
    //var elem = answer.get_object_element(0);
    foreach (var node in answer.get_elements()) {
        //Json.Array arr = node.get_array();
        Json.Object obj = node.get_object();
        //stdout.printf("%s %s\n", arr.get_string_element(0), arr.get_string_element(1));
        /*hub_list_model.set(iter, 0, false); hub_list_model.set(iter, 1, arr.get_string_element(1)); */
        string descr = obj.get_string_member("Description");
        if (descr.index_of("node_id=") == 0) descr = descr.substring(8);
        TreeIter iter;
        hub_list_model.append(out iter);
        hub_list_model.set(iter, 0, false);
        hub_list_model.set(iter, 1, obj.get_string_member("Host name"));
        hub_list_model.set(iter, 2, obj.get_string_member("Addresses"));
        hub_list_model.set(iter, 3, descr);
   }

    window.show_all();
    Gtk.main();
    return 0;
}
