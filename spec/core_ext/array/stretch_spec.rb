describe Array do
  STRETCH_CASES = [
    # 2 parameter cases
    # Message                             Test case               Expected
    "receiver same size as parameter",    [[1, 2, 3], [4, 5, 6]], [[1, 2, 3],       [4, 5, 6]],

    "receiver longer than parameter",     [[1, 2, 3], [4, 5]],    [[1, 2, 3],       [4, 5, nil]],
    "receiver shorter than parameter",    [[1, 2],    [4, 5, 6]], [[1, 2, nil],     [4, 5, 6]],

    "receiver with empty parameter",      [[1, 2, 3], []],        [[1, 2, 3],       [nil, nil, nil]],
    "receiver is empty with 1 parameter", [[],        [4, 5, 6]], [[nil, nil, nil], [4, 5, 6]],

    # 3 parameter cases
    # Message                                Test Case                          Expected
    "receiver longer than some parameters",  [[1, 2, 3], [4, 5],    [7, 8, 9]], [[1, 2, 3],       [4, 5, nil], [7, 8, 9]],
    "receiver shorter than parameters",      [[1, 2],    [4, 5, 6], [7, 8, 9]], [[1, 2, nil],     [4, 5, 6],   [7, 8, 9]],

    "receiver longer than all parameters",   [[1, 2, 3], [4, 5],    [7, 8]],    [[1, 2, 3],       [4, 5, nil], [7, 8, nil]],
    "receiver shorter than some parameters", [[1, 2],    [4, 5, 6], [7, 8]],    [[1, 2, nil],     [4, 5, 6],   [7, 8, nil]],

    "receiver is empty with 2 parameters",   [[],        [],        [7, 8, 9]], [[nil, nil, nil], [nil, nil, nil], [7, 8, 9]],
  ]

  context '.stretch' do
    STRETCH_CASES.each_slice(3) do |msg, test_case, expected|
      it "where #{msg}" do
        result = Array.stretch(*test_case)
        result.each_with_index do |r, i|
          expect(r).not_to equal(test_case[i])
          expect(r).to eq(expected[i])
        end
      end
    end
  end

  context '.stretch!' do
    STRETCH_CASES.each_slice(3) do |msg, test_case, expected|
      it "where #{msg}" do
        result = Array.stretch!(*test_case)
        result.each_with_index do |r, i|
          expect(r).to equal(test_case[i])
          expect(r).to eq(expected[i])
        end
      end
    end
  end

  context '#stretch' do
    STRETCH_CASES.each_slice(3) do |msg, test_case, expected|
      it "where #{msg}" do
        receiver, params = test_case[0], test_case[1..-1]
        result = receiver.stretch(*params)
        expect(result).not_to equal(receiver)
        expect(result).to eq(expected[0])
      end
    end
  end

  context '#stretch!' do
    STRETCH_CASES.each_slice(3) do |msg, test_case, expected|
      it "where #{msg}" do
        receiver, params = test_case[0].dup, test_case[1..-1]
        result = receiver.stretch!(*params)
        expect(result).to equal(receiver)
        expect(result).to eq(expected[0])
      end
    end
  end

  ZIP_STRETCHED_CASES = [
    # 1 parameter tests
    # Message                          Test case               Expected
    "receiver same size as parameter", [1, 2, 3], [[4, 5, 6]], [[1, 4], [2, 5], [3, 6]],
    "receiver longer than parameter",  [1, 2, 3], [[4, 5]],    [[1, 4], [2, 5], [3, nil]],
    "receiver shorter than parameter", [1, 2],    [[4, 5, 6]], [[1, 4], [2, 5], [nil, 6]],  # Different than zip

    # 2 parameter tests
    # Message                                Test case                          Expected
    "receiver same size as all parameters",  [1, 2, 3], [[4, 5, 6], [7, 8, 9]], [[1, 4, 7],   [2, 5, 8],   [3, 6, 9]],
    "receiver longer than first parameter",  [1, 2, 3], [[4, 5],    [7, 8, 9]], [[1, 4, 7],   [2, 5, 8],   [3, nil, 9]],
    "receiver shorter than all parameters",  [1, 2],    [[4, 5, 6], [7, 8, 9]], [[1, 4, 7],   [2, 5, 8],   [nil, 6, 9]],    # Different than zip
    "receiver shorter than first parameter", [1, 2],    [[4, 5, 6], [7, 8]],    [[1, 4, 7],   [2, 5, 8],   [nil, 6, nil]],  # Different than zip
    "receiver shorter than last parameter",  [1, 2],    [[4, 5],    [7, 8, 9]], [[1, 4, 7],   [2, 5, 8],   [nil, nil, 9]],  # Different than zip
    "receiver is empty with 2 parameters",   [],        [[4, 5, 6], [7, 8, 9]], [[nil, 4, 7], [nil, 5, 8], [nil, 6, 9]],    # Different than zip
  ]

  context '#zip_stretched' do
    ZIP_STRETCHED_CASES.each_slice(4) do |msg, receiver, params, expected|
      it "where #{msg}" do
        expect(receiver.zip_stretched(*params)).to eq(expected)
      end
    end
  end
end
