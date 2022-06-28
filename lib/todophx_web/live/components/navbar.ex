defmodule TodophxWeb.NavbarComponent do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <header class="px-8 py-1 mx-auto bg-p1">
      <nav class="flex flex-wrap items-center justify-between rounded-full text-indigo-content">
        <a class="inline-flex items-center py-2 hover:no-underline" href="/">
          <div class="font-bold text-white">One-O-One</div>
        </a>
        <div class="flex md:hidden">
          <button id="hamburger">
            <svg
              class="w-8 h-8"
              fill="none"
              stroke="#570DF8"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M4 6h16M4 12h16M4 18h16"
              />
            </svg>
          </button>
        </div>
        <div class="hidden w-full space-x-8 text-right toggle-ham md:flex md:w-auto text-bold md:mt-0">
          <a href="#" phx-click="new_project" class="px-4 py-1 text-sm text-white border border-white rounded" id="topnav-new-project">+ New project</a>
        </div>
      </nav>
    </header>
    """
  end
end
