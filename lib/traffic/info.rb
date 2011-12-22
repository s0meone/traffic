module Traffic
  ATTRIBUTES = [:timestamp, :count, :size, :traffic]
  Info = Struct.new(*ATTRIBUTES) do
    def traffic?
      !traffic
    end
  end
end