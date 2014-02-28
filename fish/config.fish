# http://mariuszs.github.io/
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold






#-agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n
set -g -x MAVEN_OPTS "-Xmx1024m -XX:MaxPermSize=256m "
set -g -x  JAVA_OPTS="-verbose:gc -Xloggc:gc.log -XX:+PrintGCDetails -XX:+PrintGCTimeStamps"
set -g -x  GRADLE_OPTS="-Xmx1024m -Dorg.gradle.daemon=true"
set -gx GRAILS_HOME /home/przodownik/grails-2.1.0
set -gx GRADLE_HOME /opt/gradle
set -gx GRADLE_OPTS="-Dorg.gradle.daemon=true"
set -gx JAVA_HOME /opt/jdk1.7.0_45
set -gx MAVEN_HOME /opt/apache-maven-3.1.1
set -gx M2_REPO /home/przodownik/repos
set -gx JBOSS_HOME /opt/jboss-as-7.1.1.Final
set -gx JMETER_HOME /opt/apache-jmeter-2.9

set -g -x WCS_PASSWORD slawek

set -gx PATH $JAVA_HOME/bin $MAVEN_HOME/bin $JMETER_HOME $HOME/.local/bin $PATH

alias makeRelease='mvn clean install -Prelease'
alias mvn-update='mvn versions:display-dependency-updates'
alias mvn-update-plugin='mvn versions:display-plugin-updates'
alias mvn-analize='mvn dependency:analyze'
alias mvn-source='mvn package -Dmaven.test.skip=true -DdownloadSources=true -DdownloadJavadocs=true'
alias mvni='mvn clean install'
alias mvnp='mvn clean package'
alias mvnit='mvn integration-test -PintegrationTest'
alias mvnj='mvn jetty:run'
alias mvnt='mvn tomcat7:run'
alias mvncj='mvn clean jetty:run'
alias mvnct='mvn clean tomcat7:run'
alias showhide='ls -A | egrep '^\.' '
alias svn_delete='find . -name .svn -print0 | xargs -0 rm -r  '
alias git_delete='find . -name .git -print0 | xargs -0 rm -r  '
alias mvn_generate='mvn archetype:generate'
alias mvn_desc='mvn help:describe -Dcmd=package'

alias git_short_log='git shortlog -s -n'
alias git_count_user='git shortlog -s -n | wc -l'
alias git_count_files='find . -type f -print | grep -v -E .git | wc -l'
alias git_revision_count='git log --pretty=oneline | wc -l'
alias git_revision_count_author='git log --pretty=oneline  --author=przodownikR1@gmail.com | wc -l'
#find /home/przodownik/sts3.2.0/PayByNet -name "*app*.xml" -print | xargs grep "camel" 
#find /home/przodownik/sts3.2.0/PayByNet -name 'application*'
#find . -type f -name "*html"


function display_proc --description 'proc name'
  ps -aux | grep $argv
end
function display_line --description 'filename' 
    sed -n -e 1p $argv
end

function say_hello
         echo Hello $argv $argv
  end


## magic
function fish_prompt --description 'Write out the prompt' 
	set -l last_status $status # Just calculate these once, to save a few cycles when displaying the prompt 

	if not set -q __fish_prompt_normal 
		set -g __fish_prompt_normal (set_color normal) 
	end 

	if not set -q -g __fish_classic_git_functions_defined 
		set -g __fish_classic_git_functions_defined 

		function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"

			if status --is-interactive 
				set -e __fish_prompt_user 
				commandline -f repaint ^/dev/null 
			end 
		end

		function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes" 
			if status --is-interactive 
				set -e __fish_prompt_host 
				commandline -f repaint ^/dev/null 
			end 
		end 
 	end

	switch $USER 
		case root; set prompt_symbol '#' 
	 	case '*'; set prompt_symbol '$' 
	end

	switch $USER 
		case root; set fish_color_user red
	end

	if not set -q __fish_prompt_cwd 
		set -g __fish_prompt_cwd (set_color $fish_color_host) 
	end 

	if not set -q __fish_prompt_user 
		set -g __fish_prompt_user (set_color $fish_color_user) 
	end 
	echo -n -s "$__fish_prompt_user" "$USER" "$__fish_prompt_normal" "$__fish_prompt_normal" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" (__fish_git_prompt) "$__fish_prompt_user" "$prompt_symbol" ' ' 
end 
if not set -q __prompt_initialized_2 
	set -U fish_color_user -o green 
	set -U fish_color_host cyan 
	set -U __prompt_initialized_2 
end

function fish_right_prompt -d "Write out the right prompt"

  # Time
  set_color -o black
  echo (date +%R)
  set_color $fish_color_normal

end
