package;

import kha.System;

class Main {
	public static function main() {
		System.init({title: "Space Structures", width: 1200, height: 900}, function () {
			new Project();
		});
	}
}
