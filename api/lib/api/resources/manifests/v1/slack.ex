defmodule Api.Resources.Manifests.V1.Slack do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Api.NotificationChannels.ChannelConfiguration
  alias Api.Repo

  @mandatory_keys [:name, :webhook_url]

  @doc false
  def changeset(slack, attrs) do
    slack
    |> cast(
         attrs,
         [
           :name,
           :data
         ]
       )
    |> validate_required(:name)
    |> unique_constraint(:name)
  end

  def upsert(spec) do
    {validation_status, message} = spec
                                   |> validate
    if validation_status == :bad_request do
      {validation_status, message}
    else
      slack = Repo.one(
        from nc in ChannelConfiguration,
        where: nc.name == ^spec["name"],
        limit: 1
      )

      if slack == nil do
        %ChannelConfiguration{type: :slack}
        |> changeset(attrs_from_spec(spec))
        |> Repo.insert!
        {:created, %{message: "Created Slack channel #{spec["name"]}"}}
      else
        slack
        |> changeset(attrs_from_spec(spec))
        |> Repo.update!
        {:ok, %{message: "Updated Slack channel #{spec["name"]}"}}
      end
    end
  end

  defp attrs_from_spec(spec) do
    %{
      name: Map.get(spec, "name"),
      description: Map.get(spec, "description"),
      data: %{
        webhook_url: Map.get(spec, "webhook_url")
      }
    }
  end

  defp validate(spec) do
    spec_keys = Map.keys(spec)
                |> Enum.sort
    mandatory_keys_as_string = @mandatory_keys |> Enum.map(fn key -> Atom.to_string(key) end)
    missing_keys = mandatory_keys_as_string -- spec_keys
    cond do
      missing_keys != [] ->
        {
          :bad_request,
          %{
            message: "Expected #{missing_keys |> inspect}"
          }
        }
      spec
      |> Map.get("name") == nil ->
        {:bad_request, %{message: "spec.name cannot be nil"}}
      spec
      |> Map.get("name")
      |> String.trim == "" ->
        {:bad_request, %{message: "spec.name cannot be blank"}}
      spec
      |> Map.get("webhook_url") == nil ->
        {:bad_request, %{message: "spec.webhook_url cannot be nil"}}
      spec
      |> Map.get("webhook_url")
      |> String.trim == "" ->
        {:bad_request, %{message: "spec.webhook_url cannot be blank"}}
      spec
      |> Map.get("webhook_url")
      |> invalid_webhook? ->
        {:bad_request, %{message: "spec.webhook_url is invalid"}}
      true ->
        {:ok, spec}
    end
  end

  defp invalid_webhook?(value) do
    !Regex.match?(~r/https:\/\/hooks.slack.com\/services\/\w{9}\/\w{9}\/\w+/, value)
  end
end

