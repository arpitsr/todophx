defmodule TodophxWeb.NavbarComponent do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <header class="mx-auto px-8 bg-p1 py-1">
      <nav class="text-indigo-content rounded-full flex flex-wrap items-center justify-between">
        <a class="inline-flex items-center py-2 hover:no-underline" href="/">
          <div class="text-white font-bold">One-O-One</div>
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
        <div class="toggle-ham hidden md:flex w-full md:w-auto text-right text-bold md:mt-0 space-x-8">

        </div>
      </nav>
    </header>
    """
  end
end
