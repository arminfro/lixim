{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.neovim.lixim;
in
{
  config = lib.mkIf (builtins.hasAttr "zkNotebookPath" cfg && cfg.zkNotebookPath != null) {
    home.sessionVariables.ZK_NOTEBOOK_DIR = cfg.zkNotebookPath;
    # home.packages = with pkgs; [
    #   plantuml
    #   graphviz
    # ];
    programs = {
      texlive = {
        enable = true;
        extraPackages = tpkgs: { inherit (tpkgs) scheme-small collection-fontsrecommended algorithms; };
      };
      pandoc = {
        enable = true;
        defaults = {
          pdf-engine = "pdflatex";
          citeproc = true;
          # filters = [
          #   "${pkgs.pandoc-lua-filters}/share/pandoc/filters/diagram-generator.lua"
          # ];
        };

      };
      zk = {
        enable = true;
        settings = {
          note = {
            # Language used when writing notes.
            # This is used to generate slugs or with date formats.
            language = "en";

            # The default title used for new note, if no `--title` flag is provided.
            default-title = "No Title";

            # Template used to generate a note's filename, without extension.
            filename = "{{slug title}}_{{format-date now '%d-%m-%d'}}";

            # The file extension used for the notes.
            extension = "md";

            # Template used to generate a note's content.
            # If not an absolute path, it is relative to .zk/templates/
            template = "${./templates}/default.md";

            # The charset used for random IDs.
            id-charset = "alphanum";

            # Length of the generated IDs.
            id-length = 4;

            # Letter case for the random IDs.
            id-case = "lower";
          };
          # EXTRA VARIABLES
          extra = {
            author = "";
          };
          group = {
            # GROUP OVERRIDES
            dailies = {
              paths = [ "dailies" ];
              note = {
                template = "${./templates}/daily.md";
                filename = "{{format-date now '%F'}}";
              };
            };

            tickets = {
              paths = [ "tickets" ];
              filename = "{{ title }}";
              note = {
                template = "${./templates}/ticket.md";
              };
            };

            tasks = {
              paths = [ "tasks" ];
              filename = "{{ slug title }}";
              note = {
                template = "${./templates}/task.md";
              };
            };

            wiki = {
              paths = [ "wiki" ];
              filename = "{{ slug title }}";
              group.wiki.note = {
                template = "${./templates}/wiki.md";
              };
            };
          };

          # MARKDOWN SETTINGS
          format.markdown = {
            # Enable support for #hashtags
            hashtags = true;
            # Enable support for :colon:separated:tags:
            colon-tags = false;
            multiword-tags = true;
          };

          # EXTERNAL TOOLS
          tool = {
            # Default editor used to open notes.
            editor = "nvim";

            # Pager used to scroll through long output.
            # pager = "less -FIRX"

            # Command used to preview a note during interactive fzf mode.
            fzf-preview = "bat -p --color always {-1}";
            # fzf-preview = "zk list --quiet --format full --limit 1 {-1}"
          };

          # NAMED FILTERS
          filter = {
            recents = "--sort created- --created-after 'last two weeks'";
          };

          # COMMAND ALIASES
          alias = {
            daily = "zk new --no-input \"$ZK_NOTEBOOK_DIR/dailies\" $@";
            daily-create = "zk daily --print-path";

            ticket = "zk new --no-input \"$ZK_NOTEBOOK_DIR/tickets\" $@";
            tickets-today = "zk list --modified today \"$ZK_NOTEBOOK_DIR/tickets\"";

            task = "zk new --no-input \"$ZK_NOTEBOOK_DIR/tasks\" $@";

            edit = "zk edit --interactive $@";

            # Edit the last modified note.
            edit-last = "zk edit --limit 1 --sort modified- $@";

            ls = "zk list $@";
            ed = "zk edit $@";
            edl = "zk edit-last $@";
            n = "zk new $@";

            # Edit the notes selected interactively among the notes created the last two weeks.
            recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";

            # open config
            conf = "$EDITOR \"$ZK_NOTEBOOK_DIR/.zk/config.toml\"";

            # create notes with `zk new --title "An interesting concept"`
            nt = "zk new --title \"$*\"";

            # sort by word count
            wc = "zk list --format '{{word-count}}\t{{title}}' --sort word-count $@";

            # Print the backlinks of a note
            bl = "zk list --link-to $@";

            # Browse the Git history of selected notes
            log = "zk list --quiet --format path --delimiter0 $@ | xargs -0 git log --patch --";

            # pull commit and push notes
            save = "git add . && git commit -m \"$*\" && git pull --rebase && git push";

            # look for potential new links to establish, by listing every note whose title is mentioned in the note you are working on but which are not already linked to it
            unlinked-mentions = "zk list --mentioned-by $1 --no-linked-by $1";

            # Show a random note.
            lucky = "zk list --quiet --format full --sort random --limit 1";

            # new-ticket = "zk new --title \"$ZK_TITLE\" --extra 'description=\"$ZK_DESCRIPTION\",ticket_id=\"$ZK_TICKET_ID\",testing=\"$ZK_TESTING\"' \"$ZK_DIR\""
          };

          # LSP (EDITOR INTEGRATION)
          lsp = {
            diagnostics = {
              # Report titles of wiki-links as hints.
              wiki-title = "hint";
              # Warn for dead links between notes.
              dead-link = "error";

              completion = {
                note-label = "{{title}}";
                note-filter-text = "{{title}}";
              };
            };
          };
        };
      };
    };
  };
}
