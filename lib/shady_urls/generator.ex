defmodule ShadyUrls.Generator do

  @words [
    # Thanks to http://urlify.io/ and https://verylegit.link for providing inspiration <3
    "facebook.com", "amazon.com", "paypal.com", "Win a free iPad", "ISIS registration form", "9/11", "trojan",
    "Trojan.Win32", "Genocide", "KKK", "Ku Klux Klan", "Heroin", "Cocaine", "Meth", "Weed", "Download", "Free",
    "Hentai", "Porn", "weeb", "Twitter Hack", "Facebook Hack", "Crypto", "Bitcoin", "Stolen credit cards",
    "Phishing", "White Power", "Tentacle fun time", "Windows Crack", "Free Money", "Webhost000", "Invoice",
    "Java Exploit", "Warez", "Cracked", "Botnet", "Dark Net", "xxx", "Adolf will rise", "IP Stealer",
    "Token grabber", "Discord hack", "Leaked nudes", "OnlyFans", "License key", "Secret conspiracy",
    "Illegal substances", "Midget porn", "Furry", "420", "Hot moms nearby", "Hot single women",
    "Penis enlargement pills", "Tinder", "~home", "Click Here", "FBI", "CIA", "NSA", "Donald Trump",
    "Android hack", "Malware", "Keylogger", "Root", "Win $100 000 000", "Hidden service", "Tor",
    "Onion", "Terrorism"
  ]

  @extensions [
    "pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx",
    "txt", "bin", "png", "jpg", "gif", "webp"
  ]

  @ending_extensions [
    "zip", "rar", "exe", "msi", "jar", "bat"
  ]

  @spec generate_shady_url(String.t()) :: String.t()
  def generate_shady_url(source_url) when is_binary(source_url) do
    url = String.trim_trailing(source_url, "/")

    # Seed the PRNG based off the provided source url
    :rand.seed(:default, :erlang.phash2(url))

    words = select_shady_words()
    path = Enum.join(words, "-")
    extension = Enum.random(@extensions)
    ending_extension = Enum.random(@ending_extensions)

    "#{path}.#{extension}.#{ending_extension}"
  end

  @spec select_shady_words() :: [String.t()]
  defp select_shady_words() do
    @words
    |> Enum.shuffle()
    |> Enum.take(4 + :rand.uniform(2))
    |> Enum.map(&String.downcase/1)
    |> Enum.map(&generate_random_suffix/1)
    |> Enum.to_list()
  end

  @spec generate_random_suffix(String.t()) :: String.t()
  defp generate_random_suffix(word) when is_binary(word) do
    suffix =  Stream.iterate(0, fn _ -> :rand.uniform(9) |> to_string() end)
    |> Enum.take(2 + :rand.uniform(2))
    |> Enum.join()

    word <> "-" <> suffix
  end
end
