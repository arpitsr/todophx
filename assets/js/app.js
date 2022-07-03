// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import Alpine from "alpinejs";
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import "trix";
import topbar from "../vendor/topbar";

window.Alpine = Alpine;
Alpine.start();

const Hooks = {};

Hooks.AutoFocus = {
  mounted() {
    this.el.focus();
  },
};

Hooks.ProjectAction = {
  mounted() {
    this.el.addEventListener("click", (e) => {
      console.log("project deletion click called");
      let project_id = this.el.getAttribute("data-project_id");
      this.pushEvent(
        "delete-project",
        {
          project_id: project_id,
        },
        (reply, ref) => {
          window.location.href = "/";
          console.log(reply);
        }
      );
      document.getElementById(`project-${project_id}`).remove();
    });
  },
};

Hooks.TaskAction = {
  mounted() {
    this.el.addEventListener("click", (e) => {
      let task_id = this.el.getAttribute("data-task_id");
      this.pushEvent("delete-task", {
        task_id: task_id,
      });
      document.getElementById(`task-${task_id}`).remove();
    });
  },
};

Hooks.ScrollLock = {
  mounted() {
    this.lockScroll();
  },
  destroyed() {
    this.unlockScroll();
  },
  lockScroll() {
    const scrollbarWidth =
      window.innerWidth - document.documentElement.clientWidth;
    document.body.style.paddingRight = `${scrollbarWidth}px`;
    this.scrollPosition = window.pageYOffset || document.body.scrollTop;
    document.body.classList.add("fix-position");
    document.body.style.top = `-${this.scrollPosition}px`;
  },
  unlockScroll() {
    document.body.style.paddingRight = null;
    document.body.classList.remove("fix-position");
    document.documentElement.scrollTop = this.scrollPosition;
    document.body.style.top = null;
  },
};

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
  dom: {
    onBeforeElUpdated(from, to) {
      if (from._x_dataStack) {
        window.Alpine.clone(from, to);
      }
    },
  },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (info) => topbar.show());
window.addEventListener("phx:page-loading-stop", (info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

document.addEventListener("DOMContentLoaded", () => {
  "use strict";

  let buffer = [];
  let lastKeyTime = Date.now();

  document.addEventListener("keydown", (event) => {
    const charList = "npt";
    const key = event.key.toLowerCase();

    // we are only interested in alphanumeric keys
    if (charList.indexOf(key) === -1) return;

    const currentTime = Date.now();

    if (currentTime - lastKeyTime > 1000) {
      buffer = [];
    }

    buffer.push(key);
    lastKeyTime = currentTime;
    console.log(buffer);
    if (buffer.length > 1 && buffer[0] == "n" && buffer[1] == "p") {
      document.getElementById("topnav-new-project").click();
    }
    if (buffer.length > 1 && buffer[0] == "n" && buffer[1] == "t") {
      document.getElementById("task_name").focus();
      event.preventDefault();
    }

    console.log(buffer);
  });
});
