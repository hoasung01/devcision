module AI
  class AlgorithmAnalyzerService
    def initialize
      @client = OpenAI::Client.new(
        access_token: ENV['OPENAI_API_KEY'],
        organization_id: ENV['OPENAI_ORGANIZATION_ID'] # Optional
      )
    end

    def analyze_requirements(user_input)
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            {
              role: "system",
              content: system_prompt
            },
            {
              role: "user",
              content: user_input
            }
          ],
          temperature: 0.7
        }
      )

      parse_response(response.dig("choices", 0, "message", "content"))
    end

    def suggest_algorithm(requirements)
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            {
              role: "system",
              content: algorithm_suggestion_prompt
            },
            {
              role: "user",
              content: requirements.to_json
            }
          ],
          temperature: 0.7
        }
      )

      parse_suggestions(response.dig("choices", 0, "message", "content"))
    end

    private

    def system_prompt
      <<~PROMPT
        You are an expert algorithm analyst. Analyze the user's problem description and extract:
        1. Problem type (sorting, searching, graph, etc.)
        2. Input size estimation
        3. Time complexity requirements
        4. Space complexity requirements
        5. Special requirements (stability, in-place, etc.)

        Format the response as JSON with these keys:
        {
          "problem_type": "",
          "input_size": "",
          "time_complexity": "",
          "space_complexity": "",
          "special_requirements": [],
          "explanation": ""
        }
      PROMPT
    end

    def algorithm_suggestion_prompt
      <<~PROMPT
        Based on the provided requirements, suggest the best algorithms considering:
        1. Time and space complexity match
        2. Special requirements fulfillment
        3. Implementation complexity
        4. Trade-offs and alternatives

        Format response as JSON with:
        {
          "primary_suggestion": {
            "name": "",
            "reason": "",
            "complexity": "",
            "trade_offs": []
          },
          "alternatives": [
            {
              "name": "",
              "reason": "",
              "trade_offs": []
            }
          ]
        }
      PROMPT
    end

    def parse_response(content)
      JSON.parse(content)
    rescue JSON::ParserError
      {
        error: "Failed to parse AI response",
        raw_content: content
      }
    end

    def parse_suggestions(content)
      JSON.parse(content)
    rescue JSON::ParserError
      {
        error: "Failed to parse algorithm suggestions",
        raw_content: content
      }
    end
  end
end
