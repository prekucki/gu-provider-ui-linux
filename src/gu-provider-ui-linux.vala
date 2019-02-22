using AppIndicator;
using Gtk;
using Soup;
using Json;

Window window;
Gtk.Menu menu;
Gtk.ListStore hub_list_model;

public void on_configure_menu_activate(Gtk.MenuItem menu) {
    window.show_all();
}

public void on_hub_selected_toggled(CellRendererToggle toggle, string path) {
    TreeIter iter;
    hub_list_model.get_iter(out iter, new TreePath.from_string(path));
    hub_list_model.set(iter, 0, !toggle.active);
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
    } catch (Error e) {
        stderr.printf("Error while loading GUI: %s\n", e.message);
        return 1;
    }

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

    var session = new Soup.Session();
    var message = new Soup.Message("GET", "http://localhost:61621/connections/list/all");
    session.send_message(message);
    message.response_headers.foreach ((name, val) => {
        stdout.printf ("Name: %s -> Value: %s\n", name, val);
    });
    stdout.printf("Message length: %lld\n%s\n",
                  message.response_body.length,
                  message.response_body.data);

    //string cli_hub_info;
    //Process.spawn_command_line_sync ("gu-provider --json lan list -I gu-hub", out cli_hub_info, null, null);
    //stdout.printf(cli_hub_info);
    var json_parser = new Json.Parser();
    json_parser.load_from_data((string)message.response_body.flatten().data, -1);
    //json_parser.load_from_data(cli_hub_info, -1);
    var answer = json_parser.get_root().get_array();
    //var elem = answer.get_object_element(0);
    foreach (var node in answer.get_elements()) {
        Json.Array arr = node.get_array();
        stdout.printf("%s %s\n", arr.get_string_element(0), arr.get_string_element(1));
        /*TreeIter iter;
        hub_list_model.get_iter(out iter, new TreePath.from_string(path));
        hub_list_model.set(iter, 0, !toggle.active);*/
        TreeIter iter;
        hub_list_model.append(out iter);
        hub_list_model.set(iter, 0, false);
        hub_list_model.set(iter, 1, arr.get_string_element(1));
        hub_list_model.set(iter, 2, arr.get_string_element(0));
        hub_list_model.set(iter, 3, "0xTODO");
   }

    window.show_all();
    Gtk.main();
    return 0;
}
