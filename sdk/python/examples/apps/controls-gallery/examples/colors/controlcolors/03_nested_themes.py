import flet as ft

name = "Nested Themes"


def example():
    c = ft.Container()
    c.theme = ft.Theme(
        color_scheme_seed=ft.Colors.YELLOW,
    )
    c.theme_mode = ft.ThemeMode.LIGHT

    c.content = ft.Column(
        [
            # Outside container theme
            ft.Container(
                content=ft.ElevatedButton("Outside Container theme button"),
                bgcolor=ft.Colors.SURFACE_TINT,
                padding=20,
                width=300,
            ),
            # Inherited theme with primary color overridden
            ft.Container(
                theme=ft.Theme(color_scheme=ft.ColorScheme(primary=ft.Colors.PINK)),
                content=ft.ElevatedButton("Inherited theme button"),
                bgcolor=ft.Colors.SURFACE_TINT,
                padding=20,
                width=300,
            ),
            # Unique always DARK theme
            ft.Container(
                theme=ft.Theme(color_scheme_seed=ft.Colors.INDIGO),
                theme_mode=ft.ThemeMode.DARK,
                content=ft.ElevatedButton("Unique theme button"),
                bgcolor=ft.Colors.SURFACE_TINT,
                padding=20,
                width=300,
            ),
        ]
    )

    return c
