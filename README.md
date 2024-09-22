
# Get started with Mojo🔥

## 1. Create a new project

To create a new Mojo project, we'll use [Magic](https://docs.modular.com/magic)—a virtual environment manager and package manager based on conda.

1. Install Magic on macOS or Ubuntu Linux with this command:

   ```sh
   curl-ssL https://magic.modular.com/d687dcdc-351f-4e01-a630-9a49fb339a39 |bash
   ```

   Then run the `source` command printed in your terminal.
2. Create a Mojo project called "hello-world":

   ```sh
   magic init hello-world --format mojoproject
   ```

   This creates a directory named `hello-world` and installs the Mojo project dependencies—the only dependency for a Mojo project is the `max` package (Mojo is [bundled with MAX](https://docs.modular.com/max/faq#why-bundle-mojo-with-max)).
3. Start a shell in the project virtual environment:

   ```sh
   cd hello-world && magic shell
   ```

That's it! The `magic shell` command activates the virtual environment so you can now start using Mojo. For example, you can check your Mojo version like this:

```sh
mojo --version
```

## 2. Run code in the REPL

First, let's use the Mojo [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop), which allows you to write and run Mojo code in a command prompt:

1. To start a REPL session, type `mojo` and press Enter.
2. Type `print("Hello, world!")` and press Enter twice (a blank line is required to indicate the end of an expression).
   The result looks like this:
   ```text
   $ mojo
   Welcome to Mojo! 🔥

   Expressions are delimited by a blank line.
   Type `:quit` to exit the REPL and `:mojo help repl` for further assistance.

     1> print("Hello world")
   Hello world
   ```
3. To exit REPL, type `:quit` and press Enter, or press Ctrl + D.

You can write as much code as you want in the REPL. You can press Enter to start a new line and continue writing code, and when you want Mojo to evaluate the code, press Enter twice. If there's something to print, Mojo prints it and then returns the prompt to you.

The REPL is primarily useful for short experiments because the code isn't saved. So when you want to write a real program, you need to write the code in a `.mojo` source file.

## 3. Run a Mojo file

Now let's write the code in a Mojo source file and run it with the [`mojo`](https://docs.modular.com/mojo/cli/) command:

1. Create a file named `hello.mojo` (or `hello.🔥`) and add the following code:

   ```mojo
   fnmain():
   print("Hello, world!")
   ```

   That's all you need. Save the file and return to your terminal.
2. Now run it with the `mojo` command:

   ```sh
   mojo hello.mojo
   ```

   ```output
   Hello, world!
   ```

## 4. Build an executable binary

Finally, let's build and run that same code as an executable:

1. Create an executable file with the [`build`](https://docs.modular.com/mojo/cli/build) command:

   ```sh
   mojo build hello.mojo
   ```

   The executable file uses the same name as the `.mojo` file, but you can change that with the `-o` option.
2. Then run the executable:

   ```sh
   ./hello
   ```

   ```output
   Hello, world!
   ```

The [`build`](https://docs.modular.com/mojo/cli/build) command creates a statically compiled binary file, so it contains all the code and libraries it needs to run.

You can now deactivate the virtual environment by just typing `exit`:

```sh
exit
```

## Update Mojo

To update the Mojo version in your project, use `magic add` and specify the `max` package version.

For example, if you want to always use the latest version of Mojo, you can use the `*` wildcard as the version and then simply run `magic update` (you must run `magic add` within the project path):

```sh
cd hello-world
```

```sh
magic add max
```

```sh
magic update
```

note

Although the wildcard option allows `magic update` to always install the latest version, it also updates the `magic.lock` file in your project with the explicit version you've installed. This ensures that anybody else who initializes the project also gets the same package version (until you run `magic update` again).

To be more specific with your package version, you can use any of the [Python package version specifiers](https://packaging.python.org/en/latest/specifications/version-specifiers/#id5). For example:

```sh
magic add"max~=24.4"
```

```sh
magic add"max>=24.4,<24.5"
```
