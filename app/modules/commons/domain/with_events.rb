module Commons
  module Domain
    module WithEvents
      def dispatch_event(event)
        self.uncommitted_events ||= []

        uncommitted_events << event
      end

      def clear_uncommited_events
        self.uncommitted_events = []
      end

      def uncommited_events
        uncommitted_events&.dup || []
      end

      private

      attr_accessor :uncommitted_events
    end
  end
end
