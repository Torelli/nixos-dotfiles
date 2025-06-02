import { Gtk } from "astal/gtk4";
// import { connect } from "astal/gtk4";
import PanelButton from "../PanelButton";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import BarItem from "../BarItem";
import { bash } from "../../../lib/utils";

function getLayout(layoutName: string) {
	if (layoutName.includes("English")) {
		return "en";
	} else if (layoutName.includes("Portuguese")) {
		return "pt";
	} else {
		return "?";
	}
}

export default () => {
	const hyprland = AstalHyprland.get_default();

	// 创建一个Stack实例
	const stack = new Gtk.Stack({
		transitionType: Gtk.StackTransitionType.SLIDE_UP_DOWN,
		halign: Gtk.Align.CENTER,
		hexpand: true
	});

	// 添加子页面
	stack.add_named(new Gtk.Label({ label: "en" }), "en");
	stack.add_named(new Gtk.Label({ label: "pt" }), "pt");
	stack.add_named(new Gtk.Label({ label: "?" }), "?");

	// 连接信号
	hyprland.connect("keyboard-layout", (_, kbName, layoutName) => {
		if (!kbName) {
			return;
		}
		stack.set_visible_child_name(getLayout(layoutName));
	});

	// 设置默认显示子页面
	stack.set_visible_child_name("en");

	return (
		<BarItem cssName="bar__keyboard-layout">
			<button
				onClicked={() => {
					bash(`hyprctl switchxkblayout all next`);
				}}
			>
				{stack}
			</button>
		</BarItem>
	);
};
